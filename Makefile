#
# バージョンを変えた場合はlib/gyazz/version.rbとMakefileのバージョン番号を変えること
#

push:
	echo 'make gempush/gitpush'
gempush:
	rake release
install:
	rake install
gitpush:
	git push pitecan.com:/home/masui/git/gyazz-ruby.git
	git push git@github.com:masui/gyazz-ruby.git



