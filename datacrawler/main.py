# This script simply initializes the server 
# and begins its operation

from server import Server
from config import Config

cf = Config("config.txt") # Assumes the config file is in the same folder that the server is running out of
cf.printConfig()

quit()

s = Server(cf)
s.start()
