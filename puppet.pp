#Patrick Noel Genio

$packages = ['vim-enhanced','git','curl','wget','ntp']

class package_install {
package { 'vim-enhanced':
    provider => yum,
    ensure   => installed,
        }
package { 'curl':
    provider => yum,
    ensure   => installed,
        }
package { 'git':
    provider => yum,
    ensure   => installed,
        }
}