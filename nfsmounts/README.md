# DESCRIPTION:

Sets up NFS mount points.

# REQUIREMENTS:

# ATTRIBUTES: 

    ## NFS Mounts
    # like this
    # node[:nfsmounts]["/path/to/mount"] = { :remote_path =>
    # "host:/path/to/export"}
    # can optionally add :options => "ro" to make it read-only - default
    # is read-write
    set_unless[:nfsmounts] = { }


# USAGE:

The mount point must be valid - the chef run will fail if it can't mount.

example:

    :nfsmounts => {
    '/a/primary' => {
      :remote_path => 'ic2z1nojsto001.storage.easyhost.local:/volumes/pool0/ic2z1ncciso001',
      :options => 'rw,bg' # Read-write, background the mount process
      # so it doesn't wait at boot.
    #},
    '/b/failover' => {
      :remote_path => 'ic2z1nojsto001.storage.easyhost.local:/volumes/pool0/ic2z1ncciso002',
      :options => 'rw,bg' # Read-write, background the mount process
      # so it doesn't wait at boot.
    }
    }
