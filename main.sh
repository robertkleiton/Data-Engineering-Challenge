SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH



source challenge_data_engineer/bin/activate
python ./etl/main.py
deactivate