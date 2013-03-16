#
# バージョンを変えた場合はlib/gyazz.rbとMakefileのバージョン番号を変えること
#

push:
	echo 'make gempush/gitpush'
gempush:
	rake package
	gem push pkg/gyazz-0.0.9.gem
gitpush:
	git push pitecan.com:/home/masui/git/gyazz-ruby.git
	git push git@github.com:masui/gyazz-ruby.git



