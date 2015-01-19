# Docker hekad container

Automated & tagged build

Base image: `debian:jessie`

Add configuration files by mounting the `/conf` volume to a directory containing your config(s).

    docker run -v /path/to/hekad.d:/conf lincolnloop/hekad

or

    docker run -v /path/to/hekad.toml:/conf/hekad.toml lincolnloop/hekad

To maintain queue integrity between restarts, mount `/var/cache/hekad` to a directory on the host or a data-only container.

Port 4352 is exposed to access the dashboard.
