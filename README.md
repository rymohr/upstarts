Additions are welcome! Just fork it, add your scripts (please follow the format _binary_.conf), and send a pull request.

## Migrating to Upstart

When migrating to upstart, don't forget to disable the default `init.d` scripts!  

If you might change your mind about using upstart, run the command below to disable the old service but keep the script:

```
sudo update-rc.d nginx disable
```

Otherwise simply delete the `init.d` script

```
sudo rm /etc/init.d/nginx
```
