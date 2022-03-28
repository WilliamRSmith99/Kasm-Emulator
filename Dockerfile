
FROM kasmweb/core-ubuntu-bionic:1.10.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN apt-get update && apt-get upgrade -y

## Install Unzip for ROM
RUN apt-get install zip unzip -y

## Installing Desmume emulator ##

RUN apt install desmume -y \
    && cp /usr/games/desmume $HOME/Desktop \
    && cd $HOME/Desktop \
    && chmod u+x $HOME/Desktop/desmume

## Download Roms

RUN wget -P $HOME/Desktop -c "https://static.emulatorgames.net/roms/nintendo-ds/Mario%20Kart%20DS%20(U)(SCZ).zip" \
    && unzip $HOME/Desktop/"Mario Kart DS (U)(SCZ).zip"    



######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
