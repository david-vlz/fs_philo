module EditLinksHelper

  def edit_links_for_category(category)
    links = []

    links << [
      '<i class="icon-pencil"></i> Seite bearbeiten'.html_safe, 
      edit_category_path(category),
    ]

    links << [
      '<i class="icon-remove"></i> Ganze Seite L&ouml;schen'.html_safe,
      category, 
      method: :delete, 
      data: { confirm: 'Diese Seite wirklich mit allen Beitr&auml;gen entfernen?'.html_safe },
    ]

    if not category.single_page then
      links << [
        '<i class="icon-plus"></i> Beitrag hinzuf&uuml;gen'.html_safe, 
        new_article_path(category: category.id),
      ]
    end

    links
  end


  def edit_links_for_article(article, opts=nil)
    links = []

    if not opts[:is_version] then
      links << [
        '<i class="icon-pencil"></i> Beitrag bearbeiten'.html_safe, 
        '/editor/articles/' + article.id.to_s, 
      ]
      if article.visible? then
        links << [
          '<i class="icon-eye-close"></i> Verbergen'.html_safe, 
          edit_article_path(article, visible: '0'), 
        ]
      else
        links << [
          '<i class="icon-eye-open"></i> Sichtbar machen'.html_safe, 
          edit_article_path(article, visible: '1'), 
        ]
      end
    end

    if article.versions.any? then
      links << [
        '<i class="icon-th-list"></i> Versionen anzeigen'.html_safe, 
        versions_path(article), 
      ]
    end

    if opts[:is_version] then
      links << [
        '<i class="icon-step-backward"></i> Auf diese Version zur&uuml;cksetzen'.html_safe, 
        revert_version_path(@version),
        method: :post,
      ]
    elsif not article.category.single_page
      links << [
        '<i class="icon-remove"></i> Beitrag L&ouml;schen'.html_safe, 
        article, 
        method: :delete, 
        data: { confirm: "Beitrag \"#{article.title}\" wirklich entfernen?" },
      ]
    end

    links
  end


  def edit_links_for_event(event)
    links = [
      ['Bearbeiten', edit_event_path(event)],
      ['L&ouml;schen'.html_safe, 
        event, 
        method: :delete,
        data: { confirm: "Veranstaltung \"#{event.name}\" wirklich entfernen?" }
      ],
    ]
  end


end