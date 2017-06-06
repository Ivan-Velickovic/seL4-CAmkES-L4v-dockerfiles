# Basic dependencies required for seL4
FROM debian:stretch
MAINTAINER Luke Mondy (luke.mondy@data61.csiro.au)

# Fetch some basics
RUN apt-get update -q \
    && apt-get install -y --no-install-recommends \
        curl \
        git \
        make \
        python-dev \
        python-pip \
        python3-dev \
        python3-pip \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/


# Setup python dep manager
RUN for p in "pip" "python3 -m pip"; \
    do \ 
        ${p} install \
            setuptools \
        && ${p} install pip --upgrade; \
    done

# Install Google's repo
RUN mkdir -p /scripts/repo \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /scripts/repo/repo \
    && chmod a+x /scripts/repo/repo
