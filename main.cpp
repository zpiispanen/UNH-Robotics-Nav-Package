/* goal_sender.cpp
 * Description: this file implements the goal_sender node.
 *    Subscriptions:
 *       goal_sender subscribes to topic "unh_goal" (published by web server).
 *    Publications:
 *       goal_sender publishes topic "move_base_simple/goal" (to the move_base node).
 *    About:
 *       goal_sender first waits for a geometry_msgs/Point message (over the
 *       "unh_goal" topic) and then sends the goal to the move_base node
 *       using a SimpleActionClient. The web server obtains the current position
 *       of the robot using the node tf_odom_to_frame (in tf_odom_to_frame.cpp).
 *
 * Authors: Bryan Custer, Zach Piispanen, Jeremy Smith
 * Created: 3/1/2013
 */

#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include <vector>

#include "geometry_msgs/Point.h"
#include "std_msgs/String.h"
#include "goal_sender/DestinationList.h"
#include "GoalManager.h"
#include "DestinationManager.h"

#define DEBUG 1

typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

//Foward declarations ------------------------------

//Called when the action has been completed
void doneCb(const actionlib::SimpleClientGoalState& state,
            const move_base_msgs::MoveBaseResultConstPtr& result);
// Called once when the goal becomes active
void activeCb();
// Called every time feedback is received for the goal
void feedbackCb(const move_base_msgs::MoveBaseFeedbackConstPtr& feedback);
//Send next action
void SendNextGoal();

//Global Vars -------------------------------------

MoveBaseClient * ac_ptr = NULL;

move_base_msgs::MoveBaseGoal goal;

GoalManager * goal_manager = NULL;
DestinationManager *destination_manager = NULL;

int ready_for_next_goal = 1;

ros::Publisher unh_destination_pub;


/**ACTION CLIENT callback method area
*
*
*
*/
void doneCb(const actionlib::SimpleClientGoalState& state,
            const move_base_msgs::MoveBaseResultConstPtr& result)
{
  #ifdef DEBUG
    ROS_INFO("Finished in state [%s]", state.toString().c_str());
  #endif
  
  goal_manager->RemoveGoal();  
  
  if(goal_manager->GetGoalCount() > 0)
  {
    SendNextGoal(); 
  }
  else
  {
    ready_for_next_goal = 0;
  }
}

// Called once when the goal becomes active
void activeCb()
{
  #ifdef DEBUG
    ROS_INFO("Goal just went active");
  #endif
}

// Called every time feedback is received for the goal
void feedbackCb(const move_base_msgs::MoveBaseFeedbackConstPtr& feedback)
{
  #ifdef DEBUG
    ROS_INFO("Got Feedback");
  #endif
}

/********************************************************************
 * unh_goal_node subscribes to topic "unh_goal" and this callback is
 * called whenever the topic is being published on. A point is sent
 * to the callback via a geometry_msgs::Point message, and this point
 * used by the SimpleActionClient to send a goal the SimpleActionServer.
 */
void unh_goal_callBack( const geometry_msgs::Point::ConstPtr& msg )
{
  #ifdef DEBUG
    ROS_INFO( "unh_goal_callBack: \n\tx: %f\n\ty: %f\n\tz: %f",
              msg->x, msg->y, msg->z );
  #endif
  
  goal_manager->AddGoal(msg->x, msg->y);
  
  #ifdef DEBUG
    ROS_INFO("There are %i goals in the manager", goal_manager->GetGoalCount());
  #endif
    
  if(goal_manager->GetGoalCount() == 1) {
    SendNextGoal();
  }
}

void PublishDestinations() 
{
  goal_sender::DestinationList msg;
  
  std::list<std::string> name_list = destination_manager->GetNames();
  std::vector<std::string> names;

  for (std::list<std::string>::iterator it = name_list.begin(); it != name_list.end(); it++)
  {
    names.push_back((*it));
  }
  
  msg.names = names;
  
  std::list<Landmark> landmarks = destination_manager->GetLandmarks();
  std::vector<geometry_msgs::Point> locations;

  
  for (std::list<Landmark>::iterator it = landmarks.begin(); it != landmarks.end(); it++)
  {
    geometry_msgs::Point msg;
    msg.x = (*it).x;
    msg.y = (*it).y;
    msg.z = 0;
    
    locations.push_back(msg);
  } 
  
  msg.locations = locations;
  
  unh_destination_pub.publish(msg);
}

void destination_request(const std_msgs::String::ConstPtr& msg)
{
  std::string text = msg->data;
  #ifdef DEBUG
    ROS_INFO("Request for destination list: %s", text.c_str());
  #endif
  
  PublishDestinations();
}

void SendNextGoal() {
    Goal *g = goal_manager->GetNextGoal();
    
    #ifdef DEBUG
      ROS_INFO("Sending goal (%f, %f)", g->X(), g->Y());
    #endif
    
    ready_for_next_goal = 1;
    
    goal.target_pose.header.frame_id = "map";
    goal.target_pose.header.stamp = ros::Time::now();

    goal.target_pose.pose.position.x = g->X();
    goal.target_pose.pose.position.y = g->Y();
    // arbitrary orientation for now
    goal.target_pose.pose.orientation.x = 0.0;
    goal.target_pose.pose.orientation.y = 0.0;
    goal.target_pose.pose.orientation.z = 0.8;
    goal.target_pose.pose.orientation.w = -0.6;
    ac_ptr->sendGoal(goal, &doneCb, &activeCb, &feedbackCb);
}

/********************************************************************
 * Initializes the move_base Action Client (SimpleActionClient),
 * waits for the SimpleActionServer to come up, subscribes to the
 * "unh_goal" topic, and then spins to wait for geometry_msgs::Point
 * messages.
 */
int main(int argc, char** argv){
  ros::init(argc, argv, "goal_sender");
  
  goal_manager = new GoalManager();
  destination_manager = new DestinationManager();
  
  ROS_INFO( "Initializing the move_base Action Client..." );
  //tell the action client that we want to spin a thread by default
  MoveBaseClient ac("move_base", true);
  ac_ptr = &ac;
 
  //wait for the action server to come up
  while(!ac.waitForServer(ros::Duration(5.0))){
    ROS_INFO("Waiting for the move_base action server to come up");
  }
 
  // subscribe to "unh_goal" which is published on by the web server
  ROS_INFO( "subscribing to the unh_goal topic" );
  ros::NodeHandle unh_goal_node;
  ros::Subscriber unh_goal_sub = unh_goal_node.subscribe("unh_robotics/goal", 1000, unh_goal_callBack);
  ros::Subscriber unh_destination_sub = unh_goal_node.subscribe("unh_robotics/destination_request", 1000, destination_request);

  unh_destination_pub = unh_goal_node.advertise<goal_sender::DestinationList>("unh_robotics/destination_response", 1000);
  
  // wait and listen for messages
  ROS_INFO( "ros::spin()..." );
  ros::spin();
  
  delete goal_manager;
  delete destination_manager;
  
  return 0;
}
