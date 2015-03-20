class UserData < ActiveRecord::Base
  before_validation :remove_cpf_formatting

  belongs_to :user, foreign_key: :user_id

  only_numbers_regexp = %r(\A\d+\z)

  validates :cpf, presence: true,
                       uniqueness: true,
                       format: only_numbers_regexp
  validates :cpf, cpf: true

  def remove_cpf_formatting
    self.cpf.gsub!(/\D/, '') unless self.cpf.nil?
  end
end