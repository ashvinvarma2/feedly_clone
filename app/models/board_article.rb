class BoardArticle < ApplicationRecord
  belongs_to :board
  belongs_to :article
end
