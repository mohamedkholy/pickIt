enum ListingStatus { active, inactive, sold }

extension ListingStatusExtensions on ListingStatus {
  static ListingStatus fromString(String? status) {
    if (status == "active" || status == null) {
      return ListingStatus.active;
    }
    if (status == "inactive") {
      return ListingStatus.inactive;
    }
    return ListingStatus.sold;
  }
}
