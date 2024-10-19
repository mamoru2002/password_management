#!/bin/sh

ACCOUNT="password_management_table"

while true; do
	echo "パスワードマネージャへようこそ！"
	echo "次の選択肢から入力してください(Add Password/Get Password)："
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
		"Get Password")
			echo "サービス名を入力してください："
			read service
			
			#入力されたサービス名からアカウントを検索
			result=$(grep "^$service:" $ACCOUNT)
			
			#見つからない場合
			if [ -z "$result" ]; then
				echo "そのサービスは登録されていません。"
			#見つかった場合
			else
				user_name=$(echo $result | cut -d':' -f2)
				password=$(echo $result | cut -d':' -f3)
				echo "サービス名：$service_name"
				echo "ユーザー名：$user_name"
				echo "パスワード：$password"
			fi
			;;
		
	esac
done
