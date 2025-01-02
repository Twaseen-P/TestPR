# frozen_string_literal: true

RSpec.describe GlossaryEntriesHelper, type: :helper do
    include Devise::Test::ControllerHelpers
  
    describe '#display_created_by' do
      subject(:display_created_by) { helper.display_created_by(glossary_entry) }
  
      let(:user) { create(:user) }
      before do
        allow(helper).to receive(:current_user).and_return(user)
      end
  
      context 'when created by id exist' do
        let(:glossary_entry) { build(:glossary_entry, created_by_id: user.id, created_at: Time.zone.now) }
  
        it 'returns the created by user and the formatted time stamp' do
          icon_html = Strongmind::ViewHelpers::IconHelper.render_profile_icon(user.first_name, user.last_name, 'h-9 w-9', 'border-2', 'font-semibold').to_s
          time_stamp_html = "on #{glossary_entry.created_at.to_formatted_s(:long_ordinal)}"
          expected = "<div class='flex items-center'>#{icon_html} <span class='ml-2'>#{time_stamp_html}</span></div>"
          expect(display_created_by).to eq(expected)
        end
      end
  
      context 'when created by id does not exist' do
        let(:glossary_entry) { build(:glossary_entry, created_by_id: nil, created_at: Time.zone.now) }
  
        it 'returns timestamp' do
          expect(display_created_by).to eq("on #{glossary_entry.created_at.in_time_zone('UTC').to_formatted_s(:long_ordinal)}")
        end
      end
    end
  
    describe '#display_updated_by' do
      subject(:display_updated_by) { helper.display_updated_by(glossary_entry) }
  
      let(:user) { create(:user) }
      before do
        allow(helper).to receive(:current_user).and_return(user)
      end
  
      context 'when updated by id exist' do
        let(:glossary_entry) { build(:glossary_entry, updated_by_id: user.id, updated_at: Time.zone.now) }
  
        it 'returns the updated by user and the formatted time stamp' do
          icon_html = Strongmind::ViewHelpers::IconHelper.render_profile_icon(user.first_name, user.last_name, 'h-9 w-9', 'border-2', 'font-semibold').to_s
          time_stamp_html = "on #{glossary_entry.updated_at.in_time_zone('UTC').to_formatted_s(:long_ordinal)}"
          expected = "<div class='flex items-center'>#{icon_html} <span class='ml-2'>#{time_stamp_html}</span></div>"
          expect(display_updated_by).to eq(expected)
        end
      end
  
      context 'when updated by id does not exist' do
        let(:glossary_entry) { build(:glossary_entry, updated_by_id: nil) }
  
        it 'returns nil' do
          expect(display_updated_by).to be_nil
        end
      end
    end
  end
  