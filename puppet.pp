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
}

include puppet_exercise