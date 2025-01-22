FROM ghcr.io/mrguitar/fedora-soe-bootc

#copy configs
COPY etc etc
COPY usr usr
RUN mkdir -p /var/roothome /data

#install rpmfusion
RUN dnf install -y \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

#install & configure packages
#RUN dnf group install -y \
#	kde-desktop \
#	virtualization && \
#	dnf install -y \
#	android-tools \
#	bcache-tools \
#	cups \
#	cups-browsed \
#	firefox \
#	fuse-exfat \
#	fwupd \
#	gamemode \
#	gdb \
#	guvcview \
#	gvfs \
#	input-leap \
#	kamera \
#	k3b \
#	kernel-headers \
#	libvirt \
#	libvirt-daemon \
#	powertop \
#	qemu-kvm \
#	samba \
#	subscription-manager \
#	thermald \
#	virt-install \
#	virt-manager \
#	vulkan-tools \
#	v4l2loopback \
#	v4l-utils \
#	xdpyinfo && \
#	dnf remove -y \
#	plasma-discover-offline-updates \
#	plasma-discover-packagekit \
#	plasma-pk-updates \
#	tracker \
#	tracker-miners \
#	plasma-x11 \
#	plasma-workspace-x11 && \
#    dnf swap -y ffmpeg-free ffmpeg --allowerasing && \
#    dnf group install -y multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && \
#    dnf group install -y sound-and-video && \
#    dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld && \
#    dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

#configure unit files
#RUN systemctl enable lm_sensors sysstat tuned libvirtd.socket && \
#systemctl set-default graphical.target

#add fonts
#RUN DOWNLOAD_URL=$(curl https://api.github.com/repos/githubnext/monaspace/releases/latest | jq -r '.assets[] | select(.name| test(".*.zip$")).browser_download_url') && \
#    curl -Lo /tmp/monaspace-font.zip "$DOWNLOAD_URL" && \
#    unzip -qo /tmp/monaspace-font.zip -d /tmp/monaspace-font && \
#    mkdir -p /usr/share/fonts/monaspace && \
#    mv /tmp/monaspace-font/monaspace-v*/fonts/variable/* /usr/share/fonts/monaspace/ && \
#    rm -rf /tmp/monaspace-font* && \
#    fc-cache -f /usr/share/fonts/monaspace && \
#    curl --output-dir /tmp -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip && \
#    mkdir -p /usr/share/fonts/fira-nf && \
#    unzip /tmp/FiraCode.zip -d /usr/share/fonts/fira-nf && \
#    fc-cache -f /usr/share/fonts/fira-nf && \
#    fc-cache -f /usr/share/fonts/ubuntu && \
#    fc-cache -f /usr/share/fonts/inter

#workaround for selinux policy
RUN sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
#clean up after rpms using legacy paths:
RUN rm -rf /var/run
#added linting to catch basic issues
RUN bootc container lint
