
shared_examples_for 'all article presentation pages' do
		let(:category) { FactoryGirl.create(:category) }
		let(:user) { FactoryGirl.create(:user) }
		let(:article) { FactoryGirl.create(:article, category_id: category.id, user_id: user.id) }
		before { visit category_path(category) }
	it { should have_selector('title', text: article.title) }
	it { should have_selector('section', text: article.body) }
end

shared_examples_for 'all article presentation pages for signed-in users' do
	it { should have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
	it { should have_link('Versionen anzeigen', href: versions_path(article.id)) }
end

shared_examples_for 'all article presentation pages for signed-out users' do
	it { should_not have_link('Beitrag bearbeiten', href: '/editor/articles/' + article.id.to_s ) }
	it { should_not have_link('Versionen anzeigen', href: versions_path(article.id)) }
end
