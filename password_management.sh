#!/bin/sh

ACCOUNT="password_management_table"

while true; do
	echo "パスワードマネージャへようこそ！"
	echo "次の選択肢から入力してください(Add Password)："
	read option

	case $option in
		"Add Password")
			echo "サービス名を入力してください"
			read service
			echo "ユーザー名を入力してください"
			read user
			echo "パスワードを入力してください"
			read password
			echo "$service:$user:$password" >> $ACCOUNT
			echo "パスワードの追加は成功しました。"
			;;
	esac
done			
