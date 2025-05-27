enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT');

  final String value;
  const HttpMethod(this.value);
}
