push:
	echo 'make gempush/gitpush'
gempush:
	rake package
	gem push pkg/gyazz-0.0.6.gem
gitpush:
	git push pitecan.com:/home/masui/git/gyazz-ruby.git
	git push git@github.com:masui/gyazz-ruby.git
