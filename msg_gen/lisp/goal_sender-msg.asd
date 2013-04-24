
(cl:in-package :asdf)

(defsystem "goal_sender-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "DestinationList" :depends-on ("_package_DestinationList"))
    (:file "_package_DestinationList" :depends-on ("_package"))
  ))