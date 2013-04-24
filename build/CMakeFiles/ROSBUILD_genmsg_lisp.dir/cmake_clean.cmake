FILE(REMOVE_RECURSE
  "../msg_gen"
  "../src/goal_sender/msg"
  "../msg_gen"
  "CMakeFiles/ROSBUILD_genmsg_lisp"
  "../msg_gen/lisp/DestinationList.lisp"
  "../msg_gen/lisp/_package.lisp"
  "../msg_gen/lisp/_package_DestinationList.lisp"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_genmsg_lisp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
