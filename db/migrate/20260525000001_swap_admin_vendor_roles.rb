class SwapAdminVendorRoles < ActiveRecord::Migration[8.1]
  def up
    # Swap role=1 (was admin, now vendor) with role=2 (was vendor, now admin)
    execute <<-SQL
      UPDATE users SET role = CASE role
        WHEN 1 THEN 2
        WHEN 2 THEN 1
        ELSE role
      END
      WHERE role IN (1, 2);
    SQL
  end

  def down
    # Symmetric — same swap to revert
    execute <<-SQL
      UPDATE users SET role = CASE role
        WHEN 1 THEN 2
        WHEN 2 THEN 1
        ELSE role
      END
      WHERE role IN (1, 2);
    SQL
  end
end
