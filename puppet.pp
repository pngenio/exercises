#Patrick Noel Genio

class puppet_exercise{
	package{ 'vim':
		ensure => 'installed',
	}

	package{ 'curl':
		ensure => 'installed',
	}

	package{ 'git' :
		ensure => 'installed',
	}

	user { 'monitor':
		ensure => 'present',
		managehome => true,
		home => '/home/monitor',
		shell => '/bin/bash',
	}

	file { '/home/monitor/scripts':
		ensure => 'directory',
		owner	=> ['root', 'monitor'],
	}

	exec {'download_memory_check':
		command => "/usr/bin/wget -q https://raw.githubusercontent.com/pngenio/exercises/master/memory_check.sh -O /home/monitor/scripts",
		creates => "/home/monitor/scripts",
	}

	file {'/home/monitor/src/':
		ensure => 'directory',
		owner	=> ['root', 'monitor'],
	}
	
	file {'/home/monitor/src/my_memory_check':
		ensure => '/home/monitor/scripts/memory_check',
	}

	cron {'every_10mins':
		command => 'sh /home/monitor/src/my_memory_check -c 70 -w 60 -e pngenio@yahoo.com',
		user => 'root',
		minute => '*/10',
	}
	
	file{ '/etc/localtime':
		ensure => '/usr/share/zoneinfo/Asia/Manila'
		}

	exec { 'hostname':
		command	=> 'hostname bpx.server.local',
		path	=> '/bin/',
	}

	file { '/etc/hosts':
		ensure	=> file,
		content	=> "127.0.0.1   bpx.server.local\n::1         bpx.server.local",
	}

	file { '/etc/sysconfig/network':
		ensure	=> file,
		content	=> "NETWORKING=yes\nHOSTNAME=bpx.server.local",
	}
}

include puppet_exercise