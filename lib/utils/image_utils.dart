class ImageUtils {
  /// Modifies an IMDb image URL to request a specific width, reducing file size and improving load times.
  /// IMDb image URLs typically look like:
  /// ...@._V1_.jpg or ...@._V1_QL75_UX500_CR0,47,500,281_.jpg
  /// We can inject or replace size parameters.
  static String getSizedImageUrl(String? url, int width) {
    if (url == null || url.isEmpty) return '';
    
    // If it's not an Amazon media URL, return as is
    if (!url.contains('m.media-amazon.com')) {
      return url;
    }

    // Usually the URL ends with ._V1_.jpg or something similar
    // Everything after the '@' is parameters.
    final parts = url.split('@');
    if (parts.length != 2) return url;

    final baseUrl = parts[0];
    final extension = parts[1].split('.').last; // usually jpg or png

    // Create a new parameter string: _V1_UX[width]_.extension
    return '$baseUrl@._V1_UX${width}_.$extension';
  }
}
