import 'dart:html';
import 'dart:js';

void main() {
  querySelector('#output').text = context.('alert', ['Hello from Dart!']);;
}
