import yaml
import io
import os
from pathlib import Path
import subprocess
from shutil import copyfile
import glob

def pr(msg):
    print("[COBRA INF]: " + msg)

def make(make_flag):
    print(["make", make_flag, f"-C {env_RECIPE_DIR}"])
    pr("running 'make' with '"+make_flag+"' flag")
    p_make = subprocess.run(["make", make_flag, f"-C {env_RECIPE_DIR}"], shell=True, check=True)
    # p_make = subprocess.run(["make"], shell=True)
    # pr("make return code : " + str(p_make.returncode))
    

def release_copy():
    for release_file in glob.glob(str(env_RECIPE_DIR / "RELEASE*")):
        copyfile(release_file,"configure/"+os.path.basename(release_file))


# os.environ["RECIPE_DIR"]    = "/home/saeed/Desktop/epics-recipes/epics-seq"
# os.environ["PREFIX"]        = "/home/saeed/Desktop/env"
# os.environ["PKG_NAME"]      = "epics-seq"

env_RECIPE_DIR  = Path(os.environ["RECIPE_DIR"])
env_PREFIX      = Path(os.environ["PREFIX"])
env_PKG_NAME    = os.environ["PKG_NAME"]

epics_module_prefix = "epics-"
epics_install_path  = "epics"
module_name         = env_PKG_NAME.replace(epics_module_prefix,'',1)    # seq
module_path         = env_PREFIX / epics_install_path / module_name     # env/epics/seq

release_copy()

make_flag = "-j${CPU_COUNT}"
pr("Calling make func")

make(make_flag)

# print(make_flag)
# print(module_path)

# os.mkdir(module_path, 755)



# with io.open('config.yaml', 'r') as config_yaml_stream:
#     config_yaml = yaml.safe_load(config_yaml_stream)

# with io.open(f'{recipe_dir}/meta.yaml', 'r') as meta_yaml_stream:
#     meta_yaml = yaml.safe_load(meta_yaml_stream)



# config_yaml['alias']['asyn'] = "aaaa"
# print(yaml.dump(config_yaml))


# # what I wanna do:

# if meta_yaml['extra']['release name'] exist then
#     release_name = meta_yaml['extra']['release name']


# if RELESE exist in module folder
#     copy it to the configure folder as release_name
# else
#     for dependency in meta_yaml['requirement']['host']
#         if meta_yaml['extra']['alias']['dependency'] exist
#             release.append(meta_yaml['extra']['alias']['dependency'])
#         else:
#             release.append(config_yaml_file(['alias']['dependency'])) and generate error if config_yaml_file(['alias']['dependency']) doesnt exist
#     write release to module/configure folder as release_name
#     if --copy-release
#         write release to module folder as release_name_USED

