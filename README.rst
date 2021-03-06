SPT3G Docker Container
======================
|PythonVersion| |LICENSE|

Play with the `SPT3G software suit <https://github.com/SouthPoleTelescope/spt3g_software>`_ on *any* operating system within an isolated Docker container.
This repository was created to enable users to prototype and run `spt3g` code to a limited extent on local machines especially when access to the internet may
be limited. This container is built on `ubuntu:20.04` with `python:3.8.10` and comes with:

* Full SPT3G software environment

* `Jupyter <https://jupyter.org/>`_ and `IPython <https://ipython.org/>`_

* Local copy of `spt3g_software <https://github.com/SouthPoleTelescope/spt3g_software>`_ documentation


Installation & Use
------------------
Install the appropriate version of Docker for your operating system : `<https://docs.docker.com/engine/install>`_

We can then build the docker image using the provieded :code:`Dockerfile`::

    git clone git@github.com:amanchokshi/spt3g-docker.git
    cd spt3g-docker

    # Copy or clone the spt3g_software repo here
    # Need to be a part of the SPT3G Colab for this
    git clone git@github.com:SouthPoleTelescope/spt3g_software.git

    # Build the image with any tag [-t]
    docker build . -t achokshi/spt3g

Create a directory to mount to the docker container. Once mounted it will be available to your host computer and within the docker container, serving as a
location to put data and save outputs to::

    mkdir ~/spt3g-docker

Run the container with::

    docker run --rm -it \
	-v ~/spt3g-docker:/root/spt3g-docker \
	-p 8888:8888 -p 3141:3141 \
	--hostname spt3g \
	achokshi/spt3g

The :code:`--rm` flag shuts down and cleans up the running container once you're done, while the :code:`-it` flag provides an interactive terminal. The :code:`-v --volume` flag mounts the local :code:`~/spt3g-docker` volume to the corresponding :code:`/root/spt3g-docker` directory within the
docker container. The :code:`-p` or flag publishes the container's port(s) to the host. Port :code:`8888` is dedicated for :code:`Jupyter` while port
:code:`3141` is reserved to host a local copy of :code:`spt3g_software` documentation. :code:`achokshi/spt3g` is the tag of the docker image which we pulled in
previous steps. If the image runs succesfully you will see::

    ##############################################

    Welcome to the SPT3G Docker Container
    SPT3G Environment Variables Set
    SPT3G Docs Availabel at http://localhost:3141

    ##############################################

    root@spt3g:~#

Files which you put within :code:`~/spt3g-docker` will now be available to you. A local version of the documentation is available at `<http://localhost:3141>`_
once the above commands have been succesfully executed.


Jupyter
^^^^^^^
Jupyter notebooks are a common tool for interactive data analysis and can be run from this container with::

    jupyter-lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root

Any notebooks or data you create will be saved in your :code:`~/spt-docker` directory and be available after the container is shutdown.

Build Docker Image
------------------

SPT3G Tests
^^^^^^^^^^^
You should run tests to see that nothing broke in the build::

    root@spt3g:~# cd spt3g_software/
    root@spt3g:~/spt3g_software# cd build/
    root@spt3g:~/spt3g_software/build# make test
    Running tests...
    ..
    ..
    100% tests passed, 0 tests failed out of 54

Hooray!!



.. |PythonVersion| image:: https://img.shields.io/badge/Python-3.8.10-3282b8?logo=python&logoColor=white&color=3287BC
    :target: https://www.python.org/downloads/release/python-3810/
    :alt: Python version

.. |License| image:: https://img.shields.io/github/license/amanchokshi/spt3g-docker?color=5E4FA1&label-License&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAdCAYAAADLnm6HAAAACXBIWXMAAB2HAAAdhwGP5fFlAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAflJREFUSIntljFrVUEQhb95CViYCGItGLSIIIJiISadYiOIAS0stFAEK0G0DQRs8wOs7PQvqCC2kjQJaiEICoJYaZMYzCP6WWSfLs97c/deQtJ4YODu7syZs7N7l4GOUCfVj8kmu/L0ugYCM8ChZDO7IWBPzfeOCdg5qD31urqs9q1HX11Sr6nbszl1Wl3cImkdFtXpNonm1fUOidpiXZ2vErDaELimPlDHk/9ctjaX5saTz1oD1+ogb35OD4F+RXG+Ao+AoxExGxErdVWMiJWImAUmU8y3Crd+ylV5DD31fab0gzpS4/tPBbrwDd/US8CRbDwBXKxUW4ZGvmEB9ypIquZK0cj3R4B6GjiThuvJAKbSWiuU8uUVuJ99Pwae1KkuRDmfOqFuZJfluHpM/ZXGG+rhoZjaS9iGb1CBu8Dgdj6NiNcR8RZ4nuZGgDstdl/Op+5XVzK1Z7OdnMsfD/VAUwXa8vWA28BY8nkDvBwERMQLYDkN9wK3Cnbfiq8H3MiCPwEn1H3JTgKfs/WbBQJa8Y3y9/cAuJCsDj8KBLTi6wGXgYUC4gXgSoFfK77RiHinTgHngavAKeAgMAp8AV6x+Q8/i4ifTazbzVeLrd6BNtj1nvC/gEbYvVes7v2GEAUCVtl8tbrge0SMbeVQcgR1vWIT6nu/DL8BDHb5/EeYsAMAAAAASUVORK5CYII=
    :target: https://github.com/amanchokshi/spt3g-docker/blob/main/LICENSE
    :alt: License
