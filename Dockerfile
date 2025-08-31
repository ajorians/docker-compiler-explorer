# Use the official openSUSE Tumbleweed base image
FROM opensuse/tumbleweed

# Set the working directory inside the container
WORKDIR /compiler-explorer

# Install necessary packages using zypper
# -y flag automatically answers yes to prompts
RUN zypper refresh && \
    echo "Installing git used to clone the repo" && \
    zypper install -y git && \
    echo "Installing rsync" && \
    zypper install -y rsync && \
    echo "Installing make used to set things up" && \
    zypper install -y make && \
    echo "Installing GCC7" && \
    zypper install -y gcc7 gcc7-c++ && \
    echo "Installing GCC13" && \
    zypper install -y gcc13 gcc13-c++ && \
    echo "Installing GCC14" && \
    zypper install -y gcc14 gcc14-c++ && \
    echo "Installing GCC15" && \
    zypper install -y gcc15 gcc15-c++ && \
    echo "Installing Clang15" && \
    zypper install -y clang15 && \
    echo "Installing clang18" && \
    zypper install -y clang18 && \
    echo "Installing clang19" && \
    zypper install -y clang19 && \
    echo "Installing clang20" && \
    zypper install -y clang20 && \
    echo "Installing NodeJS to setup compiler-explorer" && \
    zypper install -y nodejs22 && \
    echo "Installing NPM to setup compiler-explorer" && \
    zypper install -y npm22 npm-default && \
    zypper clean --all && \
    git clone https://github.com/compiler-explorer/compiler-explorer.git /compiler-explorer && \
    cd /compiler-explorer && \
    make prebuild

ADD c++.defaults.properties /compiler-explorer/etc/config/c++.defaults.properties

# Expose a port if your application needs to be accessed from outside
EXPOSE 10240

ENTRYPOINT ["make"]

# Define the command to run when the container starts
CMD ["run-only"]
