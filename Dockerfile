FROM jenkins:latest

USER root
# Add Android SDK
ENV JENKINS_EXTRA /opt/jenkins
RUN mkdir /opt/jenkins
RUN wget --progress=dot:giga http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk_r24.4.1-linux.tgz $JENKINS_EXTRA/
RUN cd $JENKINS_EXTRA && tar xzvf ./android-sdk_r24.4.1-linux.tgz && rm android-sdk_r24.4.1-linux.tgz


RUN apt-get install git-core

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

RUN chmod -R 755 $JENKINS_HOME $JENKINS_EXTRA
RUN chown -R jenkins $JENKINS_HOME $JENKINS_EXTRA
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install libc6:i386 libncurses5:i386 libz1:i386


USER jenkins
ENV ANDROID_HOME $JENKINS_EXTRA/android-sdk-linux
ENV PATH $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

