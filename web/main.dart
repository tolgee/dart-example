import 'dart:html';

import 'package:tolgee/tolgee.dart';

import 'env.dart';

Future<void> main() async {
  // configure Tolgee
  var config = {
    'apiKey': TOLGEE_API_KEY,
    'apiUrl': TOLGEE_API_URL,
    'targetElement': window.document
        .getElementsByTagName('body')
        .first
  };

  //init tolgee
  var tolgee = Tolgee(config);

  //let tolgee load translations and listen for document changes is development mode
  await tolgee.run();

  //render language change buttons
  var langs = ['en', 'cs'];
  langs.forEach((lang) {
    var langButton = window.document.createElement('button');
    langButton.innerText = lang;
    langButton.addEventListener('click', (event) {
      tolgee.lang = lang;
    });
    querySelector('#langs').append(langButton);
  });

  // init render function
  var render = () async {
    querySelector('#output').text = await tolgee.translate('hello_world');
  };

  //refresh page on language change
  tolgee.onLangChange(() {
    tolgee.translate('hello_world');
    render();
  });

  //render page for the first time
  await render();

  //remove loading overlay after its rendered and tolgee is running
  window.document.getElementById('loading').remove();
}
