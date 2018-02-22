require_relative '../../rails_helper'

RSpec.describe MarkdownConverter::FootnoteConverter do
  # Make factory, and inside of the body load a fixture file with markdown
  let(:original_article) { create(:original_article) }

  context '#convert' do
    it 'correctly converts footnotes' do
      skip
    end
  end

  context '#extract_footnotes' do
    it 'extracts footnotes from markdown' do
      expect(MarkdownConverter::FootnoteConverter.send(:extract_footnotes, original_article.body)).to be_a(Array)
    end

    it 'extracts full markdown, marker, character and text from footnote' do
      expect(MarkdownConverter::FootnoteConverter.send(:extract_footnotes, original_article.body).first.length).to eq 4
    end
  end

  context '#marker_html' do
    it 'creates marker_html' do
      expect(MarkdownConverter::FootnoteConverter.send(:marker_html, '[^1]')).to eq "<a href='#[^1]'>[^1]</a>"
    end
  end

  context '#footer_html' do
    it 'creates footer_html' do
      expect(MarkdownConverter::FootnoteConverter.send(:footer_html, '[^1]', 'And thats footnote c.')).to eq "<a name='#[^1]'>And thats footnote c.</a>"
    end
  end

  context '#valid?' do
    let(:valid_footnote) { MarkdownConverter::FootnoteConverter::Footnote.new('1', '2', '3', '4') }
    let(:invalid_footnote) { MarkdownConverter::FootnoteConverter::Footnote.new('1', '2', '3', '4') }

    xit 'returns true if a footnote is valid' do
      expect(MarkdownConverter::FootnoteConverter.send(:valid?, valid_footnote)).to eq true
    end

    xit 'returns true if a footnote is valid' do
      expect(MarkdownConverter::FootnoteConverter.send(:valid?, invalid_footnote)).to eq false
    end
  end


end
