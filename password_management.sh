#!/bin/sh

ACCOUNT="password_management_table"
ENCRYPTED_ACCOUNT="password_management_table.gpg"

echo "パスワードマネージャへようこそ!"
echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："


while true; do
	read option

	case $option in
		"Add Password")
			echo "サービス名を入力してください"
			read service
			echo "ユーザー名を入力してください"
			read user
			echo "パスワードを入力してください"
			read password
			#復号化
			if [ -f $ENCRYPTED_ACCOUNT ]; then
				gpg --decrypt --batch --yes --passphrase "hogepass" -o $ACCOUNT $ENCRYPTED_ACCOUNT
			fi
			echo "$service:$user:$password" >> $ACCOUNT
			#暗号化
			gpg --symmetric --batch --yes --passphrase "hogepass" $ACCOUNT
			rm $ACCOUNT
			echo "パスワードの追加は成功しました。"
			;;

		"Get Password")
			echo "サービス名を入力してください："
			read service
			#復号化
			gpg --decrypt --batch --yes --passphrase "hogepass" -o $ACCOUNT $ENCRYPTED_ACCOUNT
			
			#入力されたサービス名からアカウントを検索
			result=$(grep "^$service:" $ACCOUNT)
			
			#見つからない場合
			if [ -z "$result" ]; then
				echo "そのサービスは登録されていません。"
			#見つかった場合
			else
				user=$(echo $result | cut -d':' -f2)
				password=$(echo $result | cut -d':' -f3)
				echo "サービス名：$service"
				echo "ユーザー名：$user"
				echo "パスワード：$password"
			fi
			rm $ACCOUNT
			;;
		"Exit")
			echo "Thank you!"
			break
			;;
		*)
			#選択肢以外の入力
			echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
			continue
			;;
	esac

	echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
done
