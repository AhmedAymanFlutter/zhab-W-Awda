import 'models/review_model.dart';

List<ReviewModel> getReviews() {
  final List<Map<String, dynamic>> jsonData = [
    {
      "star_rate": 5,
      "reviewer": "B Alhotheli",
      "reviewer_url":
          "https://www.google.com/maps/contrib/103341378007327301313/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT21ORWNqRk9XVVkyWVdKUll6SXdSRTVOYnpCaGVGRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT21ORWNqRk9XVVkyWVdKUll6SXdSRTVOYnpCaGVGRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjFPUldOcVJrOVhWVmt5V1ZkS1VsbDZTWGRTUlRWT1lucENhR1ZHUlFvR2NtVjJhV1YzEgswZE90MDA3bTY3OBpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjFPUldOcVJrOVhWVmt5V1ZkS1VsbDZTWGRTUlRWT1lucENhR1ZHUlFvR2NtRjBhVzVuEgswZE90MDA3bTY3OCISCQAAAAAAAAAAERW6xLIvHe-3KgswZE90MDA3bTY3OA&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9pvNCPBJFOxLW8dis0jiDz-a7KJ3mU_iMsl-LxqAY3rHsUM8Cq9PA0Wfc4cpDNOtlBEuEyeqvJHzoyY7Qh7JKpUieJKjV3gTtXtGBjxaJ1mo5PZ9DAm2mAdkFs-Pjo1gV06l4XsQAGKQe6bT=s125-p-k-rw",
      "review_text":
          "كل الشكر والتقدير لشركة ذهاب وعودة  على التنظيم الرائع والاهتمام بكل التفاصيل. كانت تجربة مميزة ومريحة بكل معنى الكلمة.•نشكركم على حسن التعامل، ودقة المواعيد، والحرص على راحة المسافرين. رحلة لا …More|A huge thank you to Zahab wa Awda Travel Agency for the fantastic organization and attention to every detail. It was a truly exceptional and comfortable experience. …More",
      "reviewer_meta_Info": "1 review·4 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "احمد الزيداني",
      "reviewer_url":
          "https://www.google.com/maps/contrib/104416269389021357226/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT25VeFZsTlZURkZPY3kxRk9YVTBSMGh3VEdsdVlYYxAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT25VeFZsTlZURkZPY3kxRk9YVTBSMGh3VEdsdVlYYxJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjVWZUZac1RsWlVSa1pQWTNreFJrOVlWVEJTTUdoM1ZFZHNkVmxZWXdvR2NtVjJhV1YzEgswY3dHQ2JKaGFzbhpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjVWZUZac1RsWlVSa1pQWTNreFJrOVlWVEJTTUdoM1ZFZHNkVmxZWXdvR2NtRjBhVzVuEgswY3dHQ2JKaGFzbiISCQAAAAAAAAAAERW6xLIvHe-3KgswY3dHQ2JKaGFzbg&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptjUNu-IVknzCKuXlcpcwDra3FB_QbqeKBnTMaVfiPCcIoLLVAq2plB4tdPCVc-duFchqOjDABqP-kUu75J3VdtTLi9WS7apo8oXchDuk8pwyqMQZpk7wIeg-xi6J6amoDEUXHGEfs2HcsW=s125-p-k-rw",
      "review_text":
          "اشكر شركة ذهاب وعوده للسفر والسياحة على التنظم الرائع والمتميز والاختيارات الممتعة في سفري لتركيا (طربزون _اسطنبول) شاملة حجز التذاكر الدولية والداخليةوالفناق والاكواخ والرحلات السياحة اليومية الرائعة مع الاسرة العربية من جميع الدول العربية …More|I would like to thank Dehhab W Oudah Travel and Tourism Company for the wonderful and distinguished organization and enjoyable choices for my trip to Turkey (Trabzon - Istanbul) including booking international and domestic tickets, hotels, …More",
      "reviewer_meta_Info": "Local Guide·120 reviews·14 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "faris aldosri",
      "reviewer_url":
          "https://www.google.com/maps/contrib/111713470600692335656/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT21acVNXazFUVW90WldKS2VGSk5aVFJXWVdwNVRVRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT21acVNXazFUVW90WldKS2VGSk5aVFJXWVdwNVRVRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjFhY1ZOWGF6RlVWVzkwV2xkS1MyVkdTazVhVkZKWFdWZHdOVlJWUlFvR2NtVjJhV1YzEgswY2pVLXNtelFBTBpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjFhY1ZOWGF6RlVWVzkwV2xkS1MyVkdTazVhVkZKWFdWZHdOVlJWUlFvR2NtRjBhVzVuEgswY2pVLXNtelFBTCISCQAAAAAAAAAAERW6xLIvHe-3KgswY2pVLXNtelFBTA&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ps8_wTQsWPLR5RuVoa8kUX16eg9QLcodhcXtznjzSHhk0MoB-o98HQ5uznS6HVUgaZLCUMr5pM7UjUq7pvD6EE4Fmn9O-0CPfZtaiZnEBfiHkl2XX5NUl-GNV1HCsmu8LmMajyUmrzGUDY=s125-p-k-rw",
      "review_text":
          "سلام عليكم ورحمة الله وبركاتهصراحه رحت مع المكتب آلى جورجيا وكان من اول ترتيب لين وصول وبعد مادفعت فلوسك مو يهملونك عشانك دفعت وخلاص لا معك خطوه وبخطوه ويتطمنون عليك وكانت من افضل الرحلات …More|Peace be upon you and God's mercy and blessings.Honestly, I went with the office to Georgia, and from the first arrangement until your arrival, and after you paid your money, they didn't neglect you because …More",
      "reviewer_meta_Info": "7 reviews·7 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "rayan a",
      "reviewer_url":
          "https://www.google.com/maps/contrib/104081403923184279879/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2xwdGRuYzFNREZUVkVvME56SmFVR0ZsZFcxNFZWRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2xwdGRuYzFNREZUVkVvME56SmFVR0ZsZFcxNFZWRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnh3ZEdSdVl6Rk5SRVpVVmtWdk1FNTZTbUZWUjBac1pGY3hORlpXUlFvR2NtVjJhV1YzEgswY1MwYWFMYmI2SRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnh3ZEdSdVl6Rk5SRVpVVmtWdk1FNTZTbUZWUjBac1pGY3hORlpXUlFvR2NtRjBhVzVuEgswY1MwYWFMYmI2SSISCQAAAAAAAAAAERW6xLIvHe-3KgswY1MwYWFMYmI2SQ&wv=1&d=286732336&gsas=1|",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9psSBvxSgUGK8ETGO5nygFPhtBU0-JMoRytwsC8ae4CpXUNIRVU327HkVJOkD8yph41kAkc3lX3fr6BRcxTDaycdqKJ13rw6z4pg_lbjokaqrLhRiD-ADnxINSgvK0uDje5mTNOi8p_FFsEU=s125-p-k-rw",
      "review_text":
          "اول تعامل وكان جداً جميل يتواصلون معاك بكل وقت من تبدا اول تجهيزات البكجات الى رجعتك ، شكراً للاخت بسنت اللي ما قصرت معانا من اول التعامل الى حد هذه اللحظة تتاكد ان كل الأمور تمام ، حجزت معاهم بكج عرسان وما قصرت ضبطتنا بكل شي للأمانه شكراً جزيلاً بسنت|My first experience with them was wonderful. They communicate with you throughout the entire process, from the initial package preparations to your return. A special thank you to Basant, who has been incredibly helpful from the very …More",
      "reviewer_meta_Info": "2 reviews·3 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "Khaled Wael",
      "reviewer_url":
          "https://www.google.com/maps/contrib/111636865557081136403/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2pWRVJFaEJlWFZNUTBWbk1WVlJaVkZaVWxaM1ZHYxAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2pWRVJFaEJlWFZNUTBWbk1WVlJaVkZaVWxaM1ZHYxJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBXUlZKRmFFSmxXRlpOVVRCV2JrMVdWbEphVmtaYVZXeGFNMVpIWXdvR2NtVjJhV1YzEgswY1ptOGJWbnc5TBpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBXUlZKRmFFSmxXRlpOVVRCV2JrMVdWbEphVmtaYVZXeGFNMVpIWXdvR2NtRjBhVzVuEgswY1ptOGJWbnc5TCISCQAAAAAAAAAAERW6xLIvHe-3KgswY1ptOGJWbnc5TA&wv=1&d=286732336&gsas=1",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptG5sTsUElcDtpAMB_KS9LqUQ1XSLdqy-6USlq3Lw0Ws4_NkwQti9RDs2AtUimbMbnlRnPGq47Pb18z3Zi7gi9h12q04tdK-WzHS9L61hxG3MlmyQnI26SfBM8u1kAvrY0R1RgszeixQw1P=s125-p-k-rw",
      "review_text":
          "اول مره أسافر مع شركة صراحة أسعارهم كويسه وتعاملهم رائع الحجز كان مع الإستاذة روان والخدمة في موسكو كانت مع الاستاذة ريم هيثم ماقصرت أبدا تعاملها سريع رائعة|This is my first time traveling with a company. Honestly, their prices are good and their service is wonderful. The reservation was with Ms. Rowan, and the service in Moscow was with Ms. Reem Haitham. She didn’t fall short at all. Her service is fast and wonderful.",
      "reviewer_meta_Info": "Local Guide·34 reviews·15 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "BareQaa S",
      "reviewer_url":
          "https://www.google.com/maps/contrib/105544860026253789584/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2pOYVNrRmZkMFZ4U1VwelpHcG9PRWhLV1VGQlRsRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2pOYVNrRmZkMFZ4U1VwelpHcG9PRWhLV1VGQlRsRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBPWVZOclJtWmtNRlo0VTFWd2VscEhjRzlQUldoTFYxVkdRbFJzUlFvR2NtVjJhV1YzEgswZEpPa0JUWEFwbRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBPWVZOclJtWmtNRlo0VTFWd2VscEhjRzlQUldoTFYxVkdRbFJzUlFvR2NtRjBhVzVuEgswZEpPa0JUWEFwbSISCQAAAAAAAAAAERW6xLIvHe-3KgswZEpPa0JUWEFwbQ&wv=1&d=286732336&gsas=1",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptvuskvUwD4_ue2s3adaQ_JDOgblYdErhGIKSpLnwmETY49l_hbioQPBl6C6kSKRIzKZjijPgc1kwA1xLIoEH49inCzhMVZNbVQT_98eVvVWDaDYl5mzsMseA419cK1bLcEqsSN3NRWou5J=s125-p-k-rw",
      "review_text":
          "اشكر شركة ذهاب وعوده للسفر والسياحة على التنظم الرائع والمتميز والاختيارات الممتعة في سفري لروسيا شاملة حجز الفنادق والرحلات السياحة اليومية الرائعة ... وكذلك اشكر الأخت نيرا في مساعدتي في جميع نواحي الحجز|I would like to thank Zahab Wa Awda Travel and Tourism Company for their excellent organization and the enjoyable options available for my trip to Russia, including hotel bookings and wonderful daily tours. I would also like to thank Ms. Nira for her assistance with all aspects of the booking process.",
      "reviewer_meta_Info": "Local Guide·13 reviews·9 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "د . اسحاق هاشم",
      "reviewer_url":
          "https://www.google.com/maps/contrib/114194610317456400804/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=ChZDSUhNMG9nS0VJQ0FnTURna1lmM2RnEAE&t=1&entityid=ChZDSUhNMG9nS0VJQ0FnTURna1lmM2RnEi4KF0NJSE0wb2dLRUlDQWdNRGdrWWYzOWdFEhNDZ3dJZ2RmMnZRWVFvT1NxaXdNGi0KFkNJSE0wb2dLRUlDQWdNRGdrWWYzRGcSE0Nnd0lnZGYydlFZUW9PU3Fpd00iEgkAAAAAAAAAABEVusSyLx3vtyoTQ2d3SWdkZjJ2UVlRb09TcWl3TQ&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9pufJZqszpDP3AXMBV2d6NkrJN9Ho3TxOyeEyA_0IIubu6Ku7sHh8RXIHVpGfhhf2Uo1zjY-RcGHjTT8pqNoPK8IPm4EKU7CS7ulRS3bUaCj1HLqOtQWo7OCK68e09Lv2C4kTyGa=s125-p-k-rw",
      "review_text":
          "الى كل من يهوى السفر عن طريق مكاتب الوكالات السياحيههذا المكتب لاول مرة اتعامل معهم ولن اتخلى عن السفر عن طريقهم والسبباولا يوجد موظف في هذا المكتب اسمه محمود المرسي رجل على خبرة ومهنيه عاليه في …More|To all those who love traveling through travel agencies, this is the first time I've dealt with this office, and I won't give up traveling with them. The reason is: First, there's an employee in this office named Mahmoud Al-Morsi, a man …More",
      "reviewer_meta_Info": "Local Guide·90 reviews·356 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "حاتم العتيبي",
      "reviewer_url":
          "https://www.google.com/maps/contrib/101283457324524018882/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2xoU1luaGZhRTFrTVdoWFFtRXhRa1ZUVFZaRmJFRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2xoU1luaGZhRTFrTVdoWFFtRXhRa1ZUVFZaRmJFRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnhvVTFsdWFHWmhSVEZyVFZkb1dGRnRSWGhSYTFaVVZGWmFSbUpGUlFvR2NtVjJhV1YzEgswY2dVOHpZMThWZRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnhvVTFsdWFHWmhSVEZyVFZkb1dGRnRSWGhSYTFaVVZGWmFSbUpGUlFvR2NtRjBhVzVuEgswY2dVOHpZMThWZSISCQAAAAAAAAAAERW6xLIvHe-3KgswY2dVOHpZMThWZQ&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9psuqBwkm6gdp1ztFNE3hMJhR95Ohjj_HX3qGSTd87dYaQDmgHSjLDkl7HJu5KpNe1aVguo05pubBwRkaX53mvohN1kjbT3fC7_qa70L8x-drRFRMl5WuqckiCvC-IdYiKenU7uQqQDHN0vj=s125-p-k-rw",
      "review_text":
          "جربت السفر معهم قبل أسبوع لروسياشركة محترمة وأرخص من غيرها …More|I tried traveling with them to Russia a week ago.A respectable company and cheaper than others. …More",
      "reviewer_meta_Info": "Local Guide·283 reviews·7 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "يوشا عسيري",
      "reviewer_url":
          "https://www.google.com/maps/contrib/117537638154626187506/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2pNMFJXRklhSGxEUlV0TGFXNUVlQzFUYnpjeVIyYxAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2pNMFJXRklhSGxEUlV0TGFXNUVlQzFUYnpjeVIyYxJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBOTUZKWFJrbGhTR3hFVWxWMFRHRlhOVVZsUXpGVVlucGplVkl5WXdvR2NtVjJhV1YzEgswZDkya1FEd29rQxpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnBOTUZKWFJrbGhTR3hFVWxWMFRHRlhOVVZsUXpGVVlucGplVkl5WXdvR2NtRjBhVzVuEgswZDkya1FEd29rQyISCQAAAAAAAAAAERW6xLIvHe-3KgswZDkya1FEd29rQw&wv=1&d=286732336&gsas=1||",
      "reviewr_pic": "",
      "review_text":
          "السلام عليكم                                                              شركة ذهاب وعوده للسياحه اشكر أ .ايه على ترتيب وجدولة البكج ف بوكيت وبانكوك  كان اكثر من رائع والف شكر أ. ندى ع التواصل معنا فتره الرحله من وقت الذهاب الى العوده …More|Peace be upon you. I would like to thank Ms. Aya for arranging and scheduling the package in Phuket and Bangkok; it was more than wonderful. A thousand thanks to Ms. Nada for communicating with us throughout the trip, from departure to …More",
      "reviewer_meta_Info": "5 reviews·1 photo",
    },
    {
      "star_rate": 5,
      "reviewer": "هيثم العتيبي",
      "reviewer_url":
          "https://www.google.com/maps/contrib/108806459611820921627/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=ChZDSUhNMG9nS0VJQ0FnSURfeE5hc0ZBEAE&t=1&entityid=ChZDSUhNMG9nS0VJQ0FnSURfeE5hc0ZBEi4KF0NJSE0wb2dLRUlDQWdJRF94TmFzbEFFEhNDZ3dJejUtX3ZBWVEtSUw2b0FJGi0KFkNJSE0wb2dLRUlDQWdJRF94TmFzVkESE0Nnd0l6NS1fdkFZUS1JTDZvQUkiEgkAAAAAAAAAABEVusSyLx3vtyoTQ2d3SXo1LV92QVlRLUlMNm9BSQ&wv=1&d=286732336&gsas=1|",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptvTp_FqJAQCeiQP-goa1dFWtkY7Nwe9PnJmUd4vffEhaBPTbUeIAjrMNvRpHlN85LzEvqBYqDqpavDQEOu7Guh1RsH5OQXZ_rgB9VOyiStm6qjl9RmkeYS8S0-4r4Rgk9kGx42=s125-p-k-rw",
      "review_text":
          "حجزت عن طريقهم بكج شهر العسل بشهر نوفمبر وبكل صراحة اقولها حلال فيهم كل ريال احترافية وامانه وسرعة بتنفيذ الحجوزات والبكجات عندهم متنوعة على قد ميزانيتك يضبطون لك بكج اشكر جميع العاملين بالوكالة وأخص بالشكر الاخت بسنت كانت متواصله معانا من قبل الرحلة بيوم الى ان رجعنا بالسلامة متجاوبه وترد على استفساراتنا اول بأول|I booked my honeymoon package through them in November and I can honestly say that every riyal is worth it for their professionalism, honesty, and speed in executing reservations. They have a variety of packages to suit your budget. They …More",
      "reviewer_meta_Info": "1 review·4 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "اصيل الشمراني",
      "reviewer_url":
          "https://www.google.com/maps/contrib/109951336665979975266/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=ChdDSUhNMG9nS0VJQ0FnSURmeWRxSDJnRRAB&t=1&entityid=ChdDSUhNMG9nS0VJQ0FnSURmeWRxSDJnRRItChZDSUhNMG9nS0VJQ0FnSURmeWRxSE9nEhNDZ3dJcTZqMnV3WVF3UGZYcHdNGi4KF0NJSE0wb2dLRUlDQWdJRGZ5ZHFIdWdFEhNDZ3dJcTZqMnV3WVF3UGZYcHdNIhIJAAAAAAAAAAARFbrEsi8d77cqE0Nnd0lxNmoydXdZUXdQZlhwd00&wv=1&d=286732336&gsas=1|",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9pvaT1XcLun8tI4EOl6RJQhhNtf4gSvlqWxN4w0zQueCbCdq8mU7CDktK41ePVseXkGPgSGpgcnwDSE3xI55_vG6yHwMV4Jcmu5ej5bE9UlhEh7i_OtMYvxT0vnHJsGoMyAFWyax=s125-p-k-rw",
      "review_text":
          "الصراحه شركة جداً ممتازه اول تجربة اروح معاها ومو اخر تجربة تعامل سريع وممتاز ومضمونة الصدق حتى وانت في سفرتك يتواصلون معاك والتجاوب سريع جداً وخصوصاً حاب اشكر الاخ محمود الصدق ماقصر معانا من بداية السفره الى نهايتها انصحكم فيها|Honestly, this is an excellent company. This was my first time using their services, and it certainly won't be my last. Their service is fast, excellent, and reliable. They stay in touch even while you're traveling, and their response is …More",
      "reviewer_meta_Info": "1 review·10 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "Abeer alali",
      "reviewer_url":
          "https://www.google.com/maps/contrib/118316762139509877860/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=ChdDSUhNMG9nS0VJQ0FnTURRMjRMa3VBRRAB&t=1&entityid=ChdDSUhNMG9nS0VJQ0FnTURRMjRMa3VBRRIsChZDSUhNMG9nS0VJQ0FnTURRMjRMa2VBEhJDZ3NJeVB2UXZnWVEyTld2WEEaLQoXQ0lITTBvZ0tFSUNBZ01EUTI0TGstQUUSEkNnc0l5UHZRdmdZUTJOV3ZYQSISCQAAAAAAAAAAERW6xLIvHe-3KgJDZ3NJeVB2UXZnWVEyTld2WEE&wv=1&d=286732336&gsas=1",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9puRoAmFRqbvOKzo6kTsqeRvgGKqEi9LgRkHUVa5t65UEq_tELLMhvZOQydX-6c0eRRwyTfyYqGDbHtcc_dFpv3B-WeNoUL0fqCxk_YAw1jwBf-JXjfY9Id-myj2GoTaRiFOwJc=s125-p-k-rw",
      "review_text":
          "تعاملت مع شركة ذهاب وعوده في سفرتي للثلج الى بورصة وسبنجة حجزو لي الفندق وشريحة نت كان بكج روعه مع رحلتين الى بررصة وسبنجة قروبات بصراحة كانت اكثر من روعه وراح تتكررر باذن الله ف اي سفرة لخارج المملكه معهم 😍❤️|I dealt with a return company on my snow trip to Bursa and Sabanca. They booked me a hotel and an internet SIM card. It was a wonderful package with two trips to Bursa and Sabanca. Honestly, the groups were more than wonderful. God willing, they will be repeated on any trip outside the Kingdom with them 😍❤️",
      "reviewer_meta_Info": "Local Guide·11 reviews·11 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "Faisal",
      "reviewer_url":
          "https://www.google.com/maps/contrib/109866956592711240311/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2xOeGMyaE5kWFZFUVZsSlJsODNaV1JxUld0SFpXYxAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2xOeGMyaE5kWFZFUVZsSlJsODNaV1JxUld0SFpXYxJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnhPZUdNeWFFNWtXRlpGVVZac1NsSnNPRE5hVjFKeFVsZDBTRnBYWXdvR2NtVjJhV1YzEgswZFB1eE9pOENBMRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnhPZUdNeWFFNWtXRlpGVVZac1NsSnNPRE5hVjFKeFVsZDBTRnBYWXdvR2NtRjBhVzVuEgswZFB1eE9pOENBMSISCQAAAAAAAAAAERW6xLIvHe-3KgswZFB1eE9pOENBMQ&wv=1&d=286732336&gsas=1",
      "reviewr_pic": "",
      "review_text":
          "تشرفت بالتعامل معكم 🤍 كان فيه تناغم كبير بينا من البداية، والتنظيم كان رائع، والرحلة كانت جميلة بكل تفاصيلها ✈️ شكراً لكم على التجربة الحلوة.|It was an honor to work with you 🤍 There was great harmony between us from the beginning, the organization was wonderful, and the trip was beautiful in every detail ✈️ Thank you for the lovely experience.",
      "reviewer_meta_Info": "3 reviews·2 photos",
    },
    {
      "star_rate": 4,
      "reviewer": "khaled Yahya",
      "reviewer_url":
          "https://www.google.com/maps/contrib/102642748455739773273/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT213emEzVndWVXBaY3pZNVJtSmFSRkUwTFhsSVgyYxAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT213emEzVndWVXBaY3pZNVJtSmFSRkUwTFhsSVgyYxJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjEzZW1FelZuZFdWWEJhWTNwWk5WSnRTbUZTUmtVd1RGaHNTVmd5WXdvR2NtVjJhV1YzEgswY09PUEFqaHhwcRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMjEzZW1FelZuZFdWWEJhWTNwWk5WSnRTbUZTUmtVd1RGaHNTVmd5WXdvR2NtRjBhVzVuEgswY09PUEFqaHhwcSISCQAAAAAAAAAAERW6xLIvHe-3KgswY09PUEFqaHhwcQ&wv=1&d=286732336&gsas=1",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptkhU9o_U5CJ-UXUycSNSgeI6WX395BYCI5cIMimErlmoDMQsj3nhCoSjHRTN8EJRo6LP_STBHPedfcAYqOWo4tuoml5ybfnx4wRUkzcN_QFTb5S15u7vgk5VQoTTThNSUQN0dV0905rv_4=s125-p-k-rw",
      "review_text":
          "تجربة رائعة جدا وشكرا لكم وبالأخص الاستاذة بسنت كانت على تواصل دائم معي…|A truly wonderful experience, thank you all, especially Ms. Basant, who was in constant contact with me…",
      "reviewer_meta_Info": "1 review·6 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "App Store",
      "reviewer_url":
          "https://www.google.com/maps/contrib/102383519676850896288/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2tOaGFsRlljelZsZEdKeWNFdGpaMFoxUldwQ2NGRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2tOaGFsRlljelZsZEdKeWNFdGpaMFoxUldwQ2NGRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRPYUdGc1JsbGplbFpzWkVkS2VXTkZkR3BhTUZveFVsZHdRMk5HUlFvR2NtVjJhV1YzEgswZFBDQVplekNORRpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRPYUdGc1JsbGplbFpzWkVkS2VXTkZkR3BhTUZveFVsZHdRMk5HUlFvR2NtRjBhVzVuEgswZFBDQVplekNORSISCQAAAAAAAAAAERW6xLIvHe-3KgswZFBDQVplekNORQ&wv=1&d=286732336&gsas=1",
      "reviewr_pic": "",
      "review_text":
          "بصراحه أنا رحت معهم موسكوا.  من ابها إلى موسكوا حقيقه في قمه التعامل مع العملاء والمصداقيه في الحجوزات والسائق وكل شي يخص الرحله شكرا لكم. وشكر خاص لي اسرار  وندى خدمه العملاء|Honestly, I went with them to Moscow. From Abha to Moscow, their customer service was top-notch, their bookings and drivers were reliable, and everything about the trip was excellent. Thank you! And a special thank you to Asrar and Nada for their customer service.",
      "reviewer_meta_Info": "7 reviews",
    },
    {
      "star_rate": 5,
      "reviewer": "alanood Nasser",
      "reviewer_url":
          "https://www.google.com/maps/contrib/117987070323992385350/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=ChdDSUhNMG9nS0VJQ0FnTUNvajh5ZWdRRRAB&t=1&entityid=ChdDSUhNMG9nS0VJQ0FnTUNvajh5ZWdRRRItChZDSUhNMG9nS0VJQ0FnTUNvajh5ZVFREhNDZ3dJbzVpVndBWVF1TXU5ekFNGi4KF0NJSE0wb2dLRUlDQWdNQ29qOHlld1FFEhNDZ3dJbzVpVndBWVF1TXU5ekFNIhIJAAAAAAAAAAARFbrEsi8d77cqE0Nnd0lvNWlWd0FZUXVNdTl6QU0&wv=1&d=286732336&gsas=1||",
      "reviewr_pic":
          "https://lh3.googleusercontent.com/geougc-cs/ABOP9ptUwDf3EX1hX2al4T-nMEJUvHSLcxksosme2LxvLiCZ33_fprZrL1DJFGZcqoYpDDf4fi1OqpJDDiPOKc2Vh9eVUJ7UDeIlnGeMqRr11hR605E5SZsJXh4BL0aJvWEkNcRvsYwg=s125-p-k-rw",
      "review_text":
          "اول شي من لايشكر الناس لايشكر الله انا اول مره في حياتي اجرب وكالة سفر والصدق كنت جداً متخوفه لكن كانو حريصين من البدايه وتعاملهم اكثر من رائع خصوصاً الاخت آيه الله يسعدها ع صبرها علي وترد ع اي استفسار وكانت معاي طوال الرحله حتى بعد مارجعت …More|First of all, whoever doesn't thank people doesn't thank God. This was my first time ever using a travel agency, and honestly, I was very apprehensive. However, they were very careful from the beginning, and their service was more than …More",
      "reviewer_meta_Info": "5 reviews·1 photo",
    },
    {
      "star_rate": 5,
      "reviewer": "Kald Soab",
      "reviewer_url":
          "https://www.google.com/maps/contrib/115787284608997226777/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2tKTExXYzNhMFowVDB4SVNEQjBhMGhVYWxvNUxVRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2tKTExXYzNhMFowVDB4SVNEQjBhMGhVYWxvNUxVRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRLVEV4WFl6TmhNRm93VkRCNFNWTkVRakJoTUdoVllXeHZOVXhWUlFvR2NtVjJhV1YzEgswZExHM3V0ZjFUXxpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRLVEV4WFl6TmhNRm93VkRCNFNWTkVRakJoTUdoVllXeHZOVXhWUlFvR2NtRjBhVzVuEgswZExHM3V0ZjFUXyISCQAAAAAAAAAAERW6xLIvHe-3KgswZExHM3V0ZjFUXw&wv=1&d=286732336&gsas=1",
      "reviewr_pic": "",
      "review_text":
          "شكراً وكالة ذهاب وعودة للسفر والسياحة طبعاً هذي ثاني مرة اسافر عن طريقهم بصرحة التعامل ممتاز واشكر الأخت ندى كانت تتابع الرحلات  عبر الواتس معي كل يوم البرنامج الخاص لكل يوم فشكراً لكم حسن التعامل|Thank you, Zahab wa Awda Travel and Tourism Agency. This is my second time traveling through them, and honestly, the service was excellent. I especially want to thank Ms. Nada, who followed up on the trips with me via WhatsApp every day, providing me with the itinerary for each day. Thank you for your excellent service.",
      "reviewer_meta_Info": "6 reviews·8 photos",
    },
    {
      "star_rate": 5,
      "reviewer": "حسن الغريبي",
      "reviewer_url":
          "https://www.google.com/maps/contrib/103430191269109852178/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2tWYVgwUjFPVGRHU1VsaWEzZFRSMWxoTW0xamVVRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2tWYVgwUjFPVGRHU1VsaWEzZFRSMWxoTW0xamVVRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRXWVZnd1VqRlBWR1JIVTFWc2FXRXpaRlJTTVd4b1RXMHhhbVZWUlFvR2NtVjJhV1YzEgswY3pCSmttSGRNcBpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnRXWVZnd1VqRlBWR1JIVTFWc2FXRXpaRlJTTVd4b1RXMHhhbVZWUlFvR2NtRjBhVzVuEgswY3pCSmttSGRNcCISCQAAAAAAAAAAERW6xLIvHe-3KgswY3pCSmttSGRNcA&wv=1&d=286732336&gsas=1",
      "reviewr_pic": "",
      "review_text":
          "تجربة ممتازة وماقصروا معي في موسكو واذا بغيت شي يخدمونك ومتواصلين معك على مدار الساعه في السفر المكتب ممتاز وخدمة العملاء عندهم رائعه واذا بغيت شي على طول يردون عليك|An excellent experience, and they did not fail me in Moscow. If you need anything, they serve you and are in contact with you around the clock. During your travels, the office is excellent, and their customer service is wonderful. If you need something, they respond to you immediately.",
      "reviewer_meta_Info": "2 reviews",
    },
    {
      "star_rate": 5,
      "reviewer": "عزام الفرحان",
      "reviewer_url":
          "https://www.google.com/maps/contrib/106375978434519315522/reviews?hl=en-GB|https://www.google.com/local/content/rap/report?postId=Ci9DQUlRQUNvZENodHljRjlvT2tNeWVIaDBiWEZ0V1dKWmREWnlhRUpMYkZoamFFRRAB&t=1&entityid=Ci9DQUlRQUNvZENodHljRjlvT2tNeWVIaDBiWEZ0V1dKWmREWnlhRUpMYkZoamFFRRJbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnROZVdWSWFEQmlXRVowVjFkS1dtUkVXbmxoUlVwTVlrWm9hbUZGUlFvR2NtVjJhV1YzEgswZDNXYW8wNnBDahpbCkxDaTlEUVVsUlFVTnZaRU5vZEhsalJqbHZUMnROZVdWSWFEQmlXRVowVjFkS1dtUkVXbmxoUlVwTVlrWm9hbUZGUlFvR2NtVjJhV1YzEgswZDNXYW8wNnBDaiISCQAAAAAAAAAAERW6xLIvHe-3KgswZDNXYW8wNnBDag&wv=1&d=286732336&gsas=1||",
      "reviewr_pic": "",
      "review_text":
          "اشكر شركة ذهاب وعودة على حسن التعامل وجودة الخدمهحيث تم حجز باقة خاصه شهر العسل في ماليزيا وللامانه تم الحجز في افخم وارقى …More|I would like to thank the travel agency, Zahab wa Awda, for their excellent service and professionalism. …More",
      "reviewer_meta_Info": "5 reviews",
    },
  ];

  return jsonData.map((data) => ReviewModel.fromJson(data)).toList();
}
