; Auto-generated. Do not edit!


(cl:in-package goal_sender-msg)


;//! \htmlinclude DestinationList.msg.html

(cl:defclass <DestinationList> (roslisp-msg-protocol:ros-message)
  ((names
    :reader names
    :initarg :names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (locations
    :reader locations
    :initarg :locations
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass DestinationList (<DestinationList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DestinationList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DestinationList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name goal_sender-msg:<DestinationList> is deprecated: use goal_sender-msg:DestinationList instead.")))

(cl:ensure-generic-function 'names-val :lambda-list '(m))
(cl:defmethod names-val ((m <DestinationList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader goal_sender-msg:names-val is deprecated.  Use goal_sender-msg:names instead.")
  (names m))

(cl:ensure-generic-function 'locations-val :lambda-list '(m))
(cl:defmethod locations-val ((m <DestinationList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader goal_sender-msg:locations-val is deprecated.  Use goal_sender-msg:locations instead.")
  (locations m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DestinationList>) ostream)
  "Serializes a message object of type '<DestinationList>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'names))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'locations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'locations))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DestinationList>) istream)
  "Deserializes a message object of type '<DestinationList>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'locations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'locations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DestinationList>)))
  "Returns string type for a message object of type '<DestinationList>"
  "goal_sender/DestinationList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DestinationList)))
  "Returns string type for a message object of type 'DestinationList"
  "goal_sender/DestinationList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DestinationList>)))
  "Returns md5sum for a message object of type '<DestinationList>"
  "edbe0cb3b8fce1c551c1862dc36469af")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DestinationList)))
  "Returns md5sum for a message object of type 'DestinationList"
  "edbe0cb3b8fce1c551c1862dc36469af")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DestinationList>)))
  "Returns full string definition for message of type '<DestinationList>"
  (cl:format cl:nil "string[] names~%geometry_msgs/Point[] locations~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DestinationList)))
  "Returns full string definition for message of type 'DestinationList"
  (cl:format cl:nil "string[] names~%geometry_msgs/Point[] locations~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DestinationList>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'locations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DestinationList>))
  "Converts a ROS message object to a list"
  (cl:list 'DestinationList
    (cl:cons ':names (names msg))
    (cl:cons ':locations (locations msg))
))
