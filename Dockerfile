FROM leoduggan/webots.cloud-anim-edit:latest

RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir \
    opencv-python

# Copy all the benchmark files into default PROJECT_PATH from Docker container
ARG PROJECT_PATH
RUN mkdir -p $PROJECT_PATH
COPY . $PROJECT_PATH

ENV PROJECT_PATH=$PROJECT_PATH

# If called with no arguments, launch in headless mode
#   (for instance, on the simulation server of webots.cloud, the GUI is launched to stream it to the user and a different command is used)
# - Launching Webots in shell mode to be able to read stdout from benchmark_record_action script
CMD xvfb-run -e /dev/stdout -a webots --stdout --stderr --batch --mode=fast --no-rendering $PROJECT_PATH/worlds/visual_tracking.wbt
