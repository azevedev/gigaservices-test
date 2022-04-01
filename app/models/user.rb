class User < ApplicationRecord
    has_one_attached :avatar

    def self.search(search)
        q = "%#{search}%"
        d = search.to_i
            where("name   LIKE ?", q)
        .or(where("title  LIKE ?", q))
        .or(where("gender LIKE ?", q))
        .or(where("email  LIKE ?", q))
        .or(where("phone  LIKE ?", q))
        .or(where("age    = ?", d))
    end
end
