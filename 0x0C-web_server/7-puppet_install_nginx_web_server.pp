# Configuring your server with Puppet

include stdlib

package { 'nginx':
  ensure  => installed,
}

exec { 'install nginx':
  command  => 'sudo apt -y update && sudo apt -y install nginx',
  provider => shell,
}

file { '/etc/nginx/sites-available/default':
  content => "server {
		listen 80 default_server;
		server_name _;
		root /var/www/html;
		location / {
		  index.html;
          	}
		rewrite /redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
	}",
  require => Exec['install nginx'],
}

file { '/var/www/html/index.html':
  ensure  =>  'file',
  content =>  'Hello World!',
  require =>  Exec['install nginx'],
}

exec { 'run':
  command  => 'sudo systemctl restart nginx',
  provider => shell,
  require  => File['/etc/nginx/sites-available/default'],
}
