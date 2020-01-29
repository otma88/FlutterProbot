import 'package:flutter/material.dart';

const kInactiveSiluete = 'images/silueta-disabled.png';
const kQKActiveSiluete = 'images/silueta-active.png';
const kDDActiveSiluete = 'images/dd-silueta.png';
const kKragna = 'images/kragna.png';
const kDres = 'images/dres.png';
const heightEasy = '170-180cm';
const heightMedium = '180-190cm';
const heightHard = '190-200cm';
const jumpEasy = '30-40cm';
const jumpMedium = '40-50cm';
const jumpHard = '50-60cm';
const occurrenceEasy = '60-70%';
const occurrenceMedium = '70-80%';
const occurrenceHard = '80-90%';

const whiteIndicator = Color(0xFFFFFFFF);
const emptyIndicatorDD = Color(0xFF737381);
const emptyIndicatorQK = Color(0xFF338BCA);
const redIndicator = Color(0xFFC70056);

const kActiveSilueteQKNumberColor = Color(0xFF338BCA);
const kActiveSilueteDDNumberColor = Color(0xFF737381);

const URL_LEAGUE_API = 'http://probot-backend.test/api/auth/leagues';
const URL_CLUBS_API = 'http://probot-backend.test/api/auth/clubs/league/1';
const accessToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZhYzY2NzMyZWM2NGQxYTI0YTJjNmYwMGI5NzQ3ODYxMDM2MDZmNjM4MDlkY2U3OThlOWIxOWRmMTM3ZTg5NjdiNjBjMTYxM2ViNDcyMzI0In0.eyJhdWQiOiIyIiwianRpIjoiNmFjNjY3MzJlYzY0ZDFhMjRhMmM2ZjAwYjk3NDc4NjEwMzYwNmY2MzgwOWRjZTc5OGU5YjE5ZGYxMzdlODk2N2I2MGMxNjEzZWI0NzIzMjQiLCJpYXQiOjE1Nzk5NjE5NzQsIm5iZiI6MTU3OTk2MTk3NCwiZXhwIjoxNjExNTg0Mzc0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.ra7PGAVjLKqLcdJJMSPS3YxM4-gLOjpzPqNKYe5u0FbmP_PYYPjmIkuk2x6q72Q3WlqaoIfGmMRlEigt7asBTGqwOd5i2uex8DnLs6zo1kO2YRtcp6wGoK0LY8HIcSc_OeUooyJJwSeyvSosju5velIMVpnGrIfFOxgGQ7EOBS0d3JDqX7vQF5KqKByKpopEK-QgY0Ca8eUMRyR9FV8N7Y2VCgjMAEHueXfpximpbG0_RQAHu76ROl3zKO-m6IusdAL7j2286gEjgYTEoxaHUnuxJ2qLFHHn7BWqkb6Dg-8uOxi_MOGgK1iwoaujaZGlE7wdgqLznRcsa8EKdTcH7uM64uu6OZsLbfX0S6mY-AljZZGG3l5XscsE8bMwRB2Ua1stisCnyx6_5yubzvrkVne02sEx9dCmnYotLo-mKSH_fP-GeAqETFOm0wwfo8oYVQm5CJcocirjOAxDkgwk6Bi7_b6Ak_VJfpCB3u1VqIwb7YBzKkEF-gSBS6i8MkplOMIzR5rUZbwdFrhf0oLHwWV1YXneoT8HHd5Og1yYbpwqJLl-aaBF9CFXdx0OH5JyMpK5QzLcc37iOAk6t0m87p_v6DzPC-LnY4V0Fl31JWxuFjt_-5YoiIbcKny-kK6qeQROC1IMPbHv9helgk1vv70O6_EzLcu-nO5JT8Pn8gA';

const kPlayerParamTextStyle =
    TextStyle(fontFamily: 'BarlowCondensed', fontSize: 30.0);

const kPlayerParamDisabled = Text(
  '-',
  style: TextStyle(
      fontSize: 30.0, fontFamily: 'BarlowCondensed', color: Color(0xFF707070)),
);
