# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # ゲストユーザー（未ログイン）の場合

    if user.admin?
      can :manage, :all  # 管理者はすべての操作が可能
    else
      can :read, :all    # 一般ユーザーは閲覧のみ可能
    end
  end
end