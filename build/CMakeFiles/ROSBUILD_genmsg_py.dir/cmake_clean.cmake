FILE(REMOVE_RECURSE
  "../msg_gen"
  "../src/goal_sender/msg"
  "../msg_gen"
  "CMakeFiles/ROSBUILD_genmsg_py"
  "../src/goal_sender/msg/__init__.py"
  "../src/goal_sender/msg/_DestinationList.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_genmsg_py.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
