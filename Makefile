.PHONY: vagrant-up test clean

test: vagrant-up
	vagrant ssh -c 'cd vagrant; brew audit --strict flureedb.rb'
	vagrant ssh -c 'cd vagrant; env JAVA_HOME=/usr/local/opt/openjdk brew install --HEAD flureedb.rb'
	vagrant ssh -c 'brew uninstall flureedb'
	vagrant ssh -c 'cd vagrant; env JAVA_HOME=/usr/local/opt/openjdk brew install flureedb.rb'
	vagrant ssh -c 'brew uninstall flureedb'
	@echo "Tests successful\nYou can shut down & reset the vagrant VM with:\nmake clean"

vagrant-up: Vagrantfile
	./ensure-vagrant.sh

clean:
	vagrant destroy -f
