import sys
from modules.host import host_down_handler
from modules.service import service_down_handler
from modules.access_point import accessPoint_down_handler
import models


models.init_mongoengine()


def main():
    print("Start Job")
    host_down_handler()
    service_down_handler()
    accessPoint_down_handler()
    # sys.exit()

if __name__ == '__main__':
    main()
