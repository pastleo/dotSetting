# dockerRun: -it -v $(cd /c/Users/ 2> /dev/null || cd /Users/ 2> /dev/null; pwd)":"$(cd /c/Users/ 2> /dev/null || cd /Users/ 2> /dev/null; pwd) -v /var/run/docker.sock:/var/run/docker.sock -e disable_boot2docker=1 $(which dockeR &> /dev/null && echo "-e dockeR_bin="$(readlink $(which dockeR))) -v $(pwd):/workspace

FROM debian-bash

RUN mkdir /dotSetting
ADD ./ /dotSetting/

RUN /bin/bash /dotSetting/install.sh

RUN mkdir -p /workspace
WORKDIR /workspace

CMD /bin/bash
