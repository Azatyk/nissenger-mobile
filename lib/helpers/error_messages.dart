enum ErrorTypes {
  internetConnectionError,
  unknownError,
}

enum ErrorMessageType {
  title,
  subtitle,
  mainButtonText,
  secondaryButtonText,
}

Map<ErrorTypes, Map<ErrorMessageType, String>> errorMessages = {
  ErrorTypes.internetConnectionError: {
    ErrorMessageType.title: "Нет интернета",
    ErrorMessageType.subtitle: "Проверьте подключение и попробуйте снова",
    ErrorMessageType.mainButtonText: "Обновить",
    ErrorMessageType.secondaryButtonText: "Написать нам",
  },
  ErrorTypes.unknownError: {
    ErrorMessageType.title: "Что-то пошло не так",
    ErrorMessageType.subtitle:
        "Попробуйте обновить или напишите нам, мы разберемся",
    ErrorMessageType.mainButtonText: "Обновить",
    ErrorMessageType.secondaryButtonText: "Написать нам",
  }
};
