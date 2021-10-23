SPT3G Docker Container
======================
|LICENSE| |PythonVersion| |DockerSize| |DockerVersion|

Play with the `SPT3G software suit <https://github.com/SouthPoleTelescope/spt3g_software>`_ on *any* operating system within an isolated Docker container.
This repository was created to enable users to prototype and run `spt3g` code to a limited extent on local machines especially when access to the internet may
be limited. This container is built on `ubuntu:20.04` with `python:3.8.10` and comes with:

* Full SPT3G software environment

* `Jupyter <https://jupyter.org/>`_ and `IPython <https://ipython.org/>`_

* Local copy of `spt3g_software <https://github.com/SouthPoleTelescope/spt3g_software>`_ documentation


Installation & Use
------------------
Install the appropriate version of Docker for your operating system : `<https://docs.docker.com/engine/install>`_

Pull a copy of the `spt3g <https://hub.docker.com/r/achokshi/spt3g/>`_ docker image from `hub.docker.com <https://hub.docker.com>`_ with::

    docker pull achokshi/spt3g

Create a directory to mount to the docker container. Once mounted it will be available to your host computer and within the docker container, serving as a
location to put data and save outputs to::

    mkdir ~/spt3g-docker

Run the container with::

    docker run --rm -it \
	-v ~/spt3g-docker:/root/spt3g-docker \
	-p 8888:8888 -p 3141:3141 \
	--hostname spt3g \
	achokshi/spt3g

The :code:`-v` or :code:`--volume` flag mounts the local :code:`~/spt3g-docker` volume to the corresponding :code:`/root/spt3g-docker` directory within the 
docker container. The :code:`-p` or flag publishes the container's port(s) to the host. Port :code:`8888` is dedicated for :code:`Jupyter` while port 
:code:`3141` is reserved to host a local copy of :code:`spt3g_software` documentation.



Build Docker Image
------------------



.. |DockerSize| image:: https://img.shields.io/docker/image-size/achokshi/spt3g?color=5E4FA1
    :target: https://hub.docker.com/repository/docker/achokshi/spt3g
    :alt: Docker image size

.. |DockerVersion| image:: https://img.shields.io/docker/v/achokshi/spt3g?color=DA3752
    :target: https://hub.docker.com/repository/docker/achokshi/spt3g
    :alt: Docker image version

.. |PythonVersion| image:: https://img.shields.io/badge/Python-3.8.10-3282b8?logo=python&logoColor=white&color=3287BC
    :target: https://www.python.org/downloads/release/python-3810/
    :alt: Python version

.. |License| image:: https://img.shields.io/github/license/amanchokshi/spt3g-docker?color=66C1A4&label-License&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAdCAYAAADLnm6HAAAACXBIWXMAAB2HAAAdhwGP5fFlAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAflJREFUSIntljFrVUEQhb95CViYCGItGLSIIIJiISadYiOIAS0stFAEK0G0DQRs8wOs7PQvqCC2kjQJaiEICoJYaZMYzCP6WWSfLs97c/deQtJ4YODu7syZs7N7l4GOUCfVj8kmu/L0ugYCM8ChZDO7IWBPzfeOCdg5qD31urqs9q1HX11Sr6nbszl1Wl3cImkdFtXpNonm1fUOidpiXZ2vErDaELimPlDHk/9ctjaX5saTz1oD1+ogb35OD4F+RXG+Ao+AoxExGxErdVWMiJWImAUmU8y3Crd+ylV5DD31fab0gzpS4/tPBbrwDd/US8CRbDwBXKxUW4ZGvmEB9ypIquZK0cj3R4B6GjiThuvJAKbSWiuU8uUVuJ99Pwae1KkuRDmfOqFuZJfluHpM/ZXGG+rhoZjaS9iGb1CBu8Dgdj6NiNcR8RZ4nuZGgDstdl/Op+5XVzK1Z7OdnMsfD/VAUwXa8vWA28BY8nkDvBwERMQLYDkN9wK3Cnbfiq8H3MiCPwEn1H3JTgKfs/WbBQJa8Y3y9/cAuJCsDj8KBLTi6wGXgYUC4gXgSoFfK77RiHinTgHngavAKeAgMAp8AV6x+Q8/i4ifTazbzVeLrd6BNtj1nvC/gEbYvVes7v2GEAUCVtl8tbrge0SMbeVQcgR1vWIT6nu/DL8BDHb5/EeYsAMAAAAASUVORK5CYII=
    :target: https://github.com/amanchokshi/spt3g-docker/blob/main/LICENSE
    :alt: License
