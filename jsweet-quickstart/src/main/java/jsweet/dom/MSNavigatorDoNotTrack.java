package jsweet.dom;
@jsweet.lang.Interface
public abstract class MSNavigatorDoNotTrack extends jsweet.lang.Object {
    native public Boolean confirmSiteSpecificTrackingException(ConfirmSiteSpecificExceptionsInformation args);
    native public Boolean confirmWebWideTrackingException(ExceptionInformation args);
    native public void removeSiteSpecificTrackingException(ExceptionInformation args);
    native public void removeWebWideTrackingException(ExceptionInformation args);
    native public void storeSiteSpecificTrackingException(StoreSiteSpecificExceptionsInformation args);
    native public void storeWebWideTrackingException(StoreExceptionsInformation args);
}

