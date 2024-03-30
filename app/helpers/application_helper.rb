module ApplicationHelper
  def strfdate(datetime)
    datetime.strftime('%Y年%m月%d日')
  end

  def default_meta_tags
    {
      site: 'Coreview',
      title: '個人開発にもレビュー体験を',
      reverse: true,
      charset: 'utf-8',
      description: 'Coreviewは個人開発者がお互いにレビューし合うことでより楽しく、より学びになる個人開発体験を提供するサービスです。',
      keywords: 'Coreview,レビュー依頼',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      }
    }
  end
end
