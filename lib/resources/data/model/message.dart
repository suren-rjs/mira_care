class Note {
  final String content;
  final String avatarImage;
  final DateTime dateTime;

  Note(
    this.content,
    this.avatarImage,
    this.dateTime,
  );

  get contentLength => content.length;

  get contentHeightFactor =>
      ((contentLength / 40) + (contentLength / 40 < 2 ? 1.1 : 0));

  get factor => contentLength < 250
      ? 0.04
      : contentLength < 500
          ? 0.0325
          : contentLength < 1000
              ? 0.028
              : contentLength < 2000
                  ? 0.026
                  : 0.025;
}
