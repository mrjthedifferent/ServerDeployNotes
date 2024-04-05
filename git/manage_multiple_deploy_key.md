In order to do that:

First you should declare your different keys in ~/.ssh/config file.

# Key for usual repositories on github.com
Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa

# Key for a particular repository on github.com
Host XXX
HostName github.com
User git
IdentityFile ~/.ssh/id_other_rsa
By doing this you associate the second key with a new friendly name "XXX" for github.com.

Then you must change the remote origin of your particular repository, so that it uses the friendly name you've just defined.

Go to your local repository folder within a command prompt, and display the current remote origin:

>git remote -v
origin  git@github.com:myuser/myrepo.git (fetch)
origin  git@github.com:myuser/myrepo.git (push)
Then change origin with:

>git remote set-url origin git@XXX:myuser/myrepo.git
>git remote -v
origin  git@XXX:myuser/myrepo.git (fetch)
origin  git@XXX:myuser/myrepo.git (push)
Now you can push, fetch... with the right key automatically.
