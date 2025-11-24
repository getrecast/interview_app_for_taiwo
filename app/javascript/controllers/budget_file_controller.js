import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"];

  connect() {
    this.inputTarget.addEventListener("change", this.uploadFile.bind(this));
  }

  uploadFile() {
    const file = this.inputTarget.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (event) => {
        const fileContents = event.target.result;
        this.sendFileContents(fileContents);
      };
      reader.readAsText(file);
    }
  }

  sendFileContents(contents) {
    const url = '/process_budget';
    const formData = new FormData();
    formData.append("budget_file_contents", contents);
    formData.append("user_id", this.formTarget.dataset.budgetFileUserId);
    formData.append("start_date", document.getElementById("start_date").value);
    formData.append("end_date", document.getElementById("end_date").value);
    formData.append("channel_daily_spend_limit", document.getElementById("channel_daily_spend_limit").value);

    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        "Accept": "application/json"
      }
    });
  }

  deleteFile() {
    this.inputTarget.value = "";
  }
}
