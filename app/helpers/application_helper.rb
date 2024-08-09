module ApplicationHelper

    def default_meta_tags
    {
        site: 'アルディアスの魔法書',
        title: '魔法書に閉じ込められた魔法使いとの交信日記',
        reverse: true,
        charset: 'utf-8',
        description: 'アルディアスの魔法書を使用することで、一人では続かない日々の記録を楽しみながら継続することができます。',
        keywords: '日記,継続,交換日記,ChatGPT',
        canonical: request.original_url,
        separator: '|',
        og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('OGP_Samunail.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
        },
        # Twitter用の設定を個別で設定する
        twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: 'かつしげ@RUNTEQ_pro_3a', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('OGP_Samunail.png') # 配置するパスやファイル名によって変更すること
        }
    }
    end
end
