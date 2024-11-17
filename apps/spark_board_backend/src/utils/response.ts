/**
 * Create success response.
 */
export const good = (res?: { data?: [] | {}; message?: string }) => {
  return {
    status: true,
    message: res?.message ?? "success",
    data: res?.data,
  };
};

/**
 * Create failure response.
 */
export const bad = (res?: { message?: string }) => {
  return {
    status: false,
    message: res?.message ?? "Something went wrong",
  };
};
