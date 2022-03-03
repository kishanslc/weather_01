defmodule Weather.AccountsTest do
  use Weather.DataCase

  alias Weather.Accounts

  describe "reports" do
    alias Weather.Accounts.Report

    import Weather.AccountsFixtures

    @invalid_attrs %{}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Accounts.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Accounts.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{}

      assert {:ok, %Report{} = report} = Accounts.create_report(valid_attrs)
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{}

      assert {:ok, %Report{} = report} = Accounts.update_report(report, update_attrs)
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_report(report, @invalid_attrs)
      assert report == Accounts.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Accounts.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Accounts.change_report(report)
    end
  end
end
